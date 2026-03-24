module Hisend
  class Error < StandardError
    attr_reader :status_code

    def initialize(message = "Hisend API Error", status_code = nil)
      super(message)
      @status_code = status_code
    end
  end
end
