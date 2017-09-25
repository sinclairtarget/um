require 'time'

# template preprocessor
module Preprocessor
  def self.preprocess(template, page_name, topic)
    template.gsub(/\$\w+/) do |match|
      case match
      when '$name'
        page_name
      when '$topic'
        topic
      when '$time'
        Time.now.rfc2822
      else
        ''
      end
    end
  end
end
