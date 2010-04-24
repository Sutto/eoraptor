class ContentRenderer
  
  class Renderer < Struct.new(:name, :options, :renderer)
    
    def [](key)
      options[key.to_sym]
    end
    
    def render(content)
      renderer.call(content.to_s).to_s.html_safe
    end
    
    def human_name
      ::I18n.t(name, :scope => :"ui.content_renderer.renderers")
    end
    
  end
  
  class_attribute :renderers, :renderer_options
  self.renderers = {}
  
  def self.add_renderer(key, *args, &blk)
    options = args.extract_options!
    renderer = (args.pop || blk).to_proc
    self.renderers[key.to_s] = Renderer.new(key, options, renderer)
  end
  
  def self.render_for(key, content)
    renderer = self.renderers[key.to_s]
    content  = content.to_s
    renderer.present? ? renderer.render(content) : content
  end
  
  def self.for_select
    self.renderers.values.map do |r|
      [r.human_name, r.name.to_s]
    end.sort
  end
  
  def self.[](key)
    renderers[key.to_s].try(:options) || {}
  end
  
  def self.valid_format?(name)
    renderers.keys.include? name.to_s
  end
  
  def initialize(object, source_field)
    @object       = object
    @source_field = source_field
  end
  
  def original_content
    @object.send source_field
  end
  
  def renderered_content=(value)
    @object.send :"#{source_field}=", value
  end
  
  def to_html
    conversion_from = @object.format rescue nil
    self.class.render_for(conversion_from, original_content)
  end
  
  def render
    self.renderered_content = self.to_html
  end
  
  add_renderer :textile do |raw|
    RedCloth.new(raw).to_html
  end
  
  add_renderer :markdown, :filters => [:smart, :autolink] do |raw|
    RDiscount.new(raw, *ContentRenderer[:markdown].fetch(:filters, [])).to_html
  end
  
  add_renderer :raw do |raw|
    raw.to_s
  end
  
end