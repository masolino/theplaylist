require "net/http"
require "rexml/document"
require "fileutils"

class Theplaylist
  def self.download(week_number)
    url           = "http://theplayli.st/weeks/#{week_number}.xml"
    parsed_url    = Net::HTTP.get_response(URI.parse(url))
    raise "Week Not Found" if parsed_url.response.code == "404"

    xml_data = parsed_url.body
    doc      = REXML::Document.new(xml_data)
    dir      = FileUtils.mkdir_p("./Week ##{week_number}")
    FileUtils.cd dir

    doc.elements.each("music/group/song") do |song|
      filename = sanitize_filename song.attributes["title"]
      url      = song.attributes["file"]

      system(%(wget --output-document="#{ filename }" #{ url }))
    end
  end

  protected
    def self.sanitize_filename(title)
      title.gsub!(/\(|\)/, '') # filename.gsub(/[^a-z0-9]+/i, '-')
      "#{ title }.mp3"
    end
end