module StimulusComponents
  module Dropdown
    class Component < ApplicationComponent
      renders_one :trigger
      renders_one :menu

      def initialize(placement: :bottom_end, menu_class: nil)
        @placement = placement
        @menu_class = menu_class
      end

      private

      attr_reader :placement, :menu_class

      def menu_position_classes
        case placement.to_sym
        when :top_end
          "bottom-full mb-2 right-0 origin-bottom-right"
        when :top_start
          "bottom-full mb-2 left-0 origin-bottom-left"
        when :bottom_start
          "top-full mt-2 left-0 origin-top-left"
        when :bottom_end
          "top-full mt-2 right-0 origin-top-right"
        else
          "top-full mt-2 right-0 origin-top-right"
        end
      end

      def menu_classes
        [
          "absolute z-50",
          menu_position_classes,
          "min-w-48",
          "rounded-xl border border-white/10",
          "bg-surface/95 backdrop-blur-xl",
          "shadow-2xl shadow-black/40",
          "p-1",
          "hidden"
        ].tap { |classes| classes << menu_class if menu_class.present? }.join(" ")
      end
    end
  end
end
