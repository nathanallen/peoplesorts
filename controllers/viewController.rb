class ViewController

  def self.render(objects)
    objects.map do |obj|
      obj.inspect
    end.join("\r\n")
  end

  def self.render_multiple(sorts_array,output=[])
    sorts_array.each_with_index do |sorted_objects, i|
      output << "Output #{i+1}:"
      output << render(sorted_objects)
      output << "" # carriage return between recordsets
    end
    output.join("\r\n") + "\r\n" #trailing carraige return
  end
  
end