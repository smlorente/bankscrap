require 'mechanize'
require 'logger'

module BankScrap
  class Bank

    WEB_USER_AGENT = 'Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 4 Build/JOP40D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19'
    attr_accessor :headers, :accounts

    private

    def get(url)
      @http.get(url).body
    end

    def post(url, fields)
      @http.post(url, fields, @headers).body
    end

    def put(url, fields)
      @http.put(url, fields, @headers).body
    end

    # Sets temporary HTTP headers, execute a code block
    # and resets the headers
    def with_headers(tmp_headers)
      current_headers = @headers
      set_headers(tmp_headers)
      yield
    ensure
      set_headers(current_headers)
    end


    def set_headers(headers)
      @headers.merge! headers
      @http.request_headers = @headers
    end


    def initialize_cookie(url)
      log 'Initialize cookie'

      @http.url = url
      @http.get(url).body
    end

    def initialize_connection
      @http = Mechanize.new do |mechanize|
        mechanize.user_agent = WEB_USER_AGENT
        mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        mechanize.log = Logger.new(STDOUT) if @debug
      end

      @headers = {}
    end

    def log(msg)
      puts msg if @log
    end
  end
end
