class ViewController

  def self.render(*args)
    rendered_records = build_records(*args).join('')
    print rendered_records
    return rendered_records
  end

  private

  def self.build_records(title,objects,output=[])
    output << title + ":\r\n"
    output << objects.map do |obj|
                obj.inspect + "\r\n"
              end
    output << "\r\n"
  end
  
end