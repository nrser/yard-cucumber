# Namespace
module YARD
module Templates
module Helpers

# Monkey into YARD's 
# {https://www.rubydoc.info/gems/yard/YARD/Templates/Helpers/HtmlHelper HtmlHelper}
# module to add common methods we want available in HTML templates.
# 
module HtmlHelper
  
  # Original HTML-ification method, that is now referred to as `:none` markup.
  # Escapes HTML entities and replaces newlines with `<br/>`.
  # 
  # @note 2019.01.10 nrser
  #   This method used to be duplicated in `lib/templates/default/`...
  #   
  #   1.  {file:lib/templates/default/feature/html/setup.rb feature/html/setup.rb}
  #   2.  {file:lib/templates/default/featuredirectory/html/setup.rb featuredirectory/html/setup.rb}
  #   
  #   but de-duplicated it to here after creating this file for
  #   {#htmlify_cucumber_text}.
  # 
  # @see #htmlify_cucumber_text
  # 
  # @param [String] text
  #   String to be converted to HTML markup.
  # 
  # @return [String]
  #   HTML markup.
  # 
  def htmlify_with_newlines(text)
    text.split("\n").collect {|c| h(c).gsub(/\s/,'&nbsp;') }.join("<br/>")
  end
  
  # Resolve the `markup` value given an argument, as provided to 
  # {#htmlify_cucumber_text} or {#htmlify_cucumber_line}. Looks in the config
  # when given `nil`, and defaults to `:none` to preserve old behavior if it
  # finds nothing there either.
  # 
  # @param [nil | #to_sym] markup
  #   The argument value.
  # 
  # @return [Symbol]
  #   The value to use.
  # 
  def resolve_cucumber_markup(markup = nil)
    if markup.nil?
      markup = YARD::Config.options[ :'yard-cucumber.markup' ] || :none
    end
    
    markup = markup.to_sym unless markup.is_a?( Symbol )
    
    markup
  end
  
  private :resolve_cucumber_markup

  # Wrapper for HTML-ifying text from Cucumber features and scenarios that takes
  # into account the `yard-cucumber.markup` config value.
  # 
  # @param [String] text
  #   String to be converted to HTML markup.
  # 
  # @param [nil | #to_sym] markup
  #   The markup with which to parse the text:
  #   
  #   1.  `nil` consults the `yard-cucumber.markup` config setting, then 
  #       proceeds with that value as if it was passed in.
  #       
  #       If the setting is missing or has a `nil` value, then `:none` is used
  #       to maintain the same behavior as before this method was introduced.
  #       
  #   2.  `:none` uses {#htmlify_with_newlines}, which is what the call sites
  #       for this method used to use beforehand.
  #       
  #   3.  `:default` uses {#htmlify} with no `markup` argument, causing it to
  #       use whatever markup is configured in the {#options}.
  #       
  #   4.  Anything else is passed as the `markup` argument to {#htmlify}.
  # 
  # @param [Boolean] strip
  #   When `true`, {String#strip} will be called on `text` before HTML-ifying.
  #   
  #   Texts strings from features and scenarios seem to sometimes have at least
  #   leading whitespace that does not seem intended given the `.feature` file.
  #   
  #   This can trigger code-formatting on the text when processing with 
  #   Markdown, and I might imagine cause weirdness given other markups as well.
  #   
  #   *NOTE* To preserve legacy behavior `text` is *never* stripped when 
  #   `markup` is resolved to `:none`.
  # 
  # @return [String]
  #   HTML markup.
  # 
  def htmlify_cucumber_text(text, markup=nil, strip: true)
    # Resolve the `markup` {Symbol}
    markup = resolve_cucumber_markup markup
    
    # Switch off to the appropriate method.
    case markup
    when :none
      # Do what it was before: call {#htmlify_with_newlines}, escapes entities 
      # and replaces "\n" with `<br/>` tags.
      htmlify_with_newlines(text)
    when :default
      # Do whatever the rest of YARD is doing.
      htmlify(strip ? text.strip : text)
    else
      htmlify(strip ? text.strip : text, markup)
    end
  end # #htmlify_cucumber_text
  
  # Like {#htmlify_cucumber_text} but operates on single lines via {#h} for
  # `:none`.
  # 
  # @param [String] text
  #   The text to HTML-ify.
  # 
  # @param [nil | #to_sym] markup
  #   What markup to use; see {#htmlify_cucumber_text} for details.
  # 
  # @param [Boolean] strip
  #   Should `text` have {String#strip} called on it first when rendering
  #   markup?
  # 
  # @return [String]
  #   HTML.
  # 
  def htmlify_cucumber_line(text, markup=nil, strip: true)
    # Resolve the `markup` {Symbol}
    markup = resolve_cucumber_markup markup
    
    # Switch off to the appropriate method.
    case markup
    when :none
      # Do what it was before: call {#h}
      h(text)
    when :default
      # Do whatever the rest of YARD is doing.
      htmlify_line(strip ? text.strip : text)
    else
      htmlify_line(strip ? text.strip : text, markup)
    end
  end # #htmlify_cucumber_line
  
end # module HtmlHelper

# /Namespace
end # module YARD
end # module Templates
end # module Helpers
