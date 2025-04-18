# frozen_string_literal: true

Heroicon.configure do |config|
  config.variant = :outline # Options are :solid, :outline and :mini

  ##
  # You can set a default class, which will get applied to every icon with
  # the given variant. To do so, un-comment the line below.
  config.default_class = { solid: "h-5 w-5", outline: "h-5 w-5", mini: "h-4 w-4" }
end
