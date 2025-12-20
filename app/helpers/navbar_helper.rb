module NavbarHelper
  def nav_link(name, path)
    class_name = current_page?(path) ? "text-white font-semibold" : "text-gray-300 hover:text-white"
    link_to name, path, class: class_name
  end
end
