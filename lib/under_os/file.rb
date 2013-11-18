class UnderOs::File
  attr_reader :path, :mode

  def self.open(path, *args, &block)
    new path, *args, &block
  end

  def self.read(path, *args)
    new(path, *args).read
  end

  def self.write(path, content)
    new(path, "w"){|f| f.write(content) }
  end

  def self.size(path)
    new(path).size
  end

  def self.delete(path)
    NSFileManager.defaultManager.removeItemAtPath(UnderOs::File.path(path), error:nil)
  end

  def self.path(path)
    path.to_s[0] == '/' ? path : NSHomeDirectory().stringByAppendingPathComponent(path)
  end

  def self.tmp(filename, &block)
    new NSTemporaryDirectory().stringByAppendingPathComponent(filename), "w", &block
  end

  def self.exists?(path, is_dir=nil)
    NSFileManager.defaultManager.fileExistsAtPath(UnderOs::File.path(path), isDirectory:is_dir)
  end

  def self.file?(path)
    exists?(path, false)
  end

  def self.dir?(path)
    exists?(path, true)
  end

  def initialize(path, mode="r", &block)
    @path = UnderOs::File.path(path)
    @mode = mode

    yield(self) if block_given?
  end

  def url
    @url ||= NSURL.fileURLWithPath(@path)
  end

  def read(size=nil)
    open
    data = if size == nil
      @handle.readDataToEndOfFile
    else
      @handle.readDataOfLength(size)
    end
    close

    @mode == "b" ? data : NSString.alloc.initWithData(data, encoding:NSUTF8StringEncoding)
  end

  def write(content)
    if ! UnderOs::File.exists?(@path)
      NSFileManager.defaultManager.createFileAtPath @path, contents:nil, attributes:nil
    end

    content = content.dataUsingEncoding(NSUTF8StringEncoding) if content.is_a?(String)

    open
    @handle.writeData content
    close
  end

  def open
    @handle = if @mode == "r"
      NSFileHandle.fileHandleForReadingAtPath(@path)
    else
      NSFileHandle.fileHandleForWritingAtPath(@path)
    end

    @handle.seekToEndOfFile if ["w+", "a"].include?(@mode)
  end

  def close
    @handle.closeFile
    @handle = nil
  end

  def seek(offset)
    @handle.seekToFileOffset(offset)
  end

  def rewind
    seek 0
  end

  def size
    NSFileManager.defaultManager.attributesOfItemAtPath(@path, error: nil).fileSize
  end

  def truncate(size)
    @handle.truncateFileAtOffset(size)
  end

end
