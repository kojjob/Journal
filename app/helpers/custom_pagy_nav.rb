module CustomPagyNav
  def pagy_nav(pagy)
    tags = []
    left = pagy.series.first
    right = pagy.series.last

    tags << (pagy.prev ? link_to("Previous", pagy_url_for(pagy, pagy.prev), class: "relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50") : tag.span("Previous", class: "relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-300 bg-gray-100 cursor-not-allowed"))

    pagy.series.each do |item|
      if item == pagy.page
        tags << tag.span(item, class: "relative inline-flex items-center px-4 py-2 border border-gray-300 bg-blue-50 text-sm font-medium text-blue-600")
      elsif item == :gap
        tags << tag.span("...", class: "relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700")
      else
        tags << link_to(item, pagy_url_for(pagy, item), class: "relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50")
      end
    end

    tags << (pagy.next ? link_to("Next", pagy_url_for(pagy, pagy.next), class: "relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50") : tag.span("Next", class: "relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-300 bg-gray-100 cursor-not-allowed"))

    tag.nav(tag.div(safe_join(tags), class: "relative z-0 inline-flex rounded-md shadow-sm -space-x-px"), "aria-label": "pagination")
  end
end
