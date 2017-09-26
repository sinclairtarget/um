require 'time'
require 'date'

# template preprocessor
module Preprocessor
  def self.preprocess(template, page_name, topic)
    template.gsub(/\$\w+/) do |match|
      case match
      when '$name'
        page_name
      when '$NAME'
        page_name.upcase
      when '$topic'
        topic
      when '$time'
        Time.now.rfc2822
      when '$date'
        Date.today.strftime("%B %d, %Y")
      else
        match
      end
    end
  end
end
