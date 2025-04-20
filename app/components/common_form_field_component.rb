class CommonFormFieldComponent < ViewComponent::Base
    attr_reader :form, :field_name, :field_type, :options

    def initialize(form:, field_name:, field_type: :text_field, options: {})
      @form = form
      @field_name = field_name
      @field_type = field_type
      @options = options
    end

    private

    def default_label_class
      "block text-sm font-medium text-gray-700"
    end

    def default_field_class
      "w-full px-4 py-2 mt-1 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-transparent focus:outline-none"
    end

    def merged_options
      options.merge(class: [ default_field_class, options[:class] ].compact.join(" "))
    end
end
