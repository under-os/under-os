#
# A little wrap to handle iOS HTTP requests receiving
#
class UnderOs::HTTP::Request
  class Receiver
    def initialize(request)
      @request = request
      @data    = NSMutableData.dataWithCapacity(0)
    end

    def connection(connection, didReceiveResponse:response)
      @response = response
      @data.setLength(0)
      emit(:response)
    end

    def connection(connection, didReceiveData:data)
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
      response = {response: UnderOs::HTTP::Response.new(@data, @response)}

      @request.emit(event, response)
      @request.emit(:complete, response) if event == :failure || event == :success
    end
  end
end
