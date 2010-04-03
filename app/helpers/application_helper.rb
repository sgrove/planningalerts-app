# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def page_matches?(options)
    if options[:action].is_a?(Array)
      options[:action].any?{|a| current_page?(:controller => options[:controller], :action => a) }
    else
      current_page?(:controller => options[:controller], :action => options[:action])
    end
  end
  
  def li_selected(m)
    content_tag(:li, :class => ("selected" if page_matches?(m))) do
      yield
    end
  end

  def meters_in_words_as_array(meters)
    if meters < 1000
      [meters, "m"]
    else
      [meters / 1000, "km"]
    end
  end
  
  def meters_in_words(meters)
    meters_in_words_as_array(meters).join(" ")
  end
end