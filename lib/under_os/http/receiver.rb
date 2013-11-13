#
# A little wrap to handle iOS HTTP requests receiving
#
class UnderOs::HTTP::Request
  class Receiver
    def initialize(request, stream=false)
      @request = request
      @stream  = stream
      @data    = NSMutableData.dataWithCapacity(0)
    end

    def connection(connection, didReceiveResponse:response)
      @data.setLength(0)
      @response = UnderOs::HTTP::Response.new(response, @data)

      emit(:response)
    end

    def connection(connection, didReceiveData:data)
      @data.setLength(0) if @stream
      @data.appendData(data)
      emit(:data)
    end

    # def connection(connection, willCacheResponse:cachedResponse)
    #   return nil # don't cache
    # end

    def connection(connection, didFailWithError:error)
      emit(:failure)
    end

    def connectionDidFinishLoading(connection)
      emit(:success)
    end

    def emit(event)
      @request.emit(event, response: @response)
      @request.emit(:complete, response: @response) if event == :failure || event == :success
    end
  end
end
