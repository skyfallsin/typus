require "test_helper"

class Admin::FiltersHelperTest < ActiveSupport::TestCase

  include Admin::FiltersHelper

  should "build_filters"

  should "relationship_filter"

  context "date_filter" do

    should "return an array" do
      output = date_filter("request", "filter")
      expected = "filter",
                 [["Today", "today"], ["Last few days", "last_few_days"], ["Last 7 days", "last_7_days"], ["Last 30 days", "last_30_days"]],
                 "Show all dates"
      assert_equal expected, output
    end

  end

  context "boolean_filter" do

    setup do
      @resource = Post
    end

    should "return an array" do
      output = boolean_filter("request", "filter")
      expected = "filter",
                 [["True", "True"], ["False", "False"]],
                 "Show by filter"
      assert_equal expected, output
    end

  end

  context "string_filter" do

    setup do
      @resource = Post
    end

    should "return an array" do
      output = string_filter("request", "status")
      expected = "status",
                 {"unpublished"=>"unpublished", "pending"=>"pending", "published"=>"published"},
                 "Show by status"
      assert_equal expected, output
    end

  end

  context "predefined_filters" do

    should "have a value" do
      expected = [["All", "index", "unscoped"]]
      assert_equal expected, predefined_filters
    end

    should "return my filter" do
      @predefined_filters = "mock"
      assert_equal "mock", predefined_filters
    end

  end

  def link_to(*args); args; end

end
