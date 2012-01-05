# require 'spec_helper'

describe "Navigation", :type => :request do
  context "all links in all pages should work" do
    collected_paths, visited_paths = ['/'], []
    begin
      path = collected_paths.first
      collected_paths.delete_at(0)
      it "visiting `#{path}`" do
        visit path
        visited_paths << path
        # Collect all links in this page
        all('a').each do |a| 
          collected_paths << a[:href] unless visited_paths.include? a[:href]
        end
      end
    end until collected_paths.empty?
  end
end