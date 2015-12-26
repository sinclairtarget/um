# template preprocessor
module Preprocessor
  def self.preprocess(template, page_name, topic)
    template.gsub(/\$\w+/) do |match|
      case match
      when '$name'
        page_name
      when '$topic'
        topic
      else
        ""
      end
    end
  end
end
