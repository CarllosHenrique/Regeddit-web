# frozen_string_literal: true

module AuthBrandingPanel
  class Component < ViewComponent::Base
    def initialize(
      quote: "Nexus mudou completamente a forma como nossa equipe de engenharia discute arquitetura. A velocidade e a clareza da interface são incomparáveis.",
      author_name: "Sofia Andrade",
      author_title: "CTO na TechFlow",
      avatar_url: "https://i.pravatar.cc/100?img=68"
    )
      @quote = quote
      @author_name = author_name
      @author_title = author_title
      @avatar_url = avatar_url
    end

    private

    attr_reader :quote, :author_name, :author_title, :avatar_url
  end
end
