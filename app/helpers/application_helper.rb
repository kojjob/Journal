module ApplicationHelper
  include Pagy::Frontend

  def custom_pagy_nav(pagy)
    tags = []

    tags << (pagy.prev ? link_to("Previous", pagy_url_for(pagy, pagy.prev), class: "px-3 py-2 bg-white border rounded-md text-gray-700 hover:bg-gray-50") :
                         content_tag(:span, "Previous", class: "px-3 py-2 bg-gray-100 border rounded-md text-gray-500 cursor-not-allowed"))

    pagy.series.each do |item|
      tags << case item
      when Integer
                link_to(item, pagy_url_for(pagy, item), class: "px-3 py-2 bg-white border rounded-md text-gray-700 hover:bg-gray-50")
      when :gap
                content_tag(:span, "...", class: "px-3 py-2 border rounded-md")
      when String  # Current page
                content_tag(:span, item, class: "px-3 py-2 bg-blue-500 text-white border rounded-md")
      end
    end

    tags << (pagy.next ? link_to("Next", pagy_url_for(pagy, pagy.next), class: "px-3 py-2 bg-white border rounded-md text-gray-700 hover:bg-gray-50") :
                         content_tag(:span, "Next", class: "px-3 py-2 bg-gray-100 border rounded-md text-gray-500 cursor-not-allowed"))

    content_tag(:nav, content_tag(:div, safe_join(tags), class: "flex space-x-2"), class: "mt-8 flex justify-center", 'aria-label': "pagination")
  end
end
