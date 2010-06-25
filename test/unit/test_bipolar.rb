require File.join(File.dirname(__FILE__), 'test_helper')

class Doc
  include MongoMapper::Document
end

class Image
  include MongoMapper::Document
end

class BipolarTest < Test::Unit::TestCase

  def teardown
    Doc.all.each &:destroy
    Image.all.each &:destroy
  end

  should "have Bipolar" do
    assert Bipolar
  end

  context "A Doc w/ Bipolar plugged in" do
    setup do
      Doc.plugin Bipolar
    end

    should "have bipolar associations" do
      assert Doc.bipolar_associations.is_a?(Set)
    end

    context "that embeds_many :images" do
      setup do
        Doc.embeds_many :images
        @doc = Doc.new
      end

      should "have embedded_images" do
        assert @doc.respond_to?(:embedded_images=)
        assert @doc.respond_to?(:embedded_images)
      end

      should "have images" do
        assert @doc.respond_to?(:images=)
        assert @doc.respond_to?(:images)
      end

      context "with a bunch of images" do
        setup do
          @images = [Image.create!(:name => 'Ryan'), Image.create!(:name => 'Blake')]
        end

        should "assign multiple documents" do
          @doc.images = @images
          @doc.save!

          assert_equal @images.map(&:_id), Doc.first.embedded_images.map(&:_id)
          assert_equal @images, Doc.first.images
          assert Doc.first.attributes.include?("embedded_images")
          assert Doc.first.attributes["embedded_images"].is_a? Array
        end
      end
    end

    context "that embeds_one :image" do
      setup do
        Doc.embeds_one :image
        @doc = Doc.new
      end

      should "have image" do
        assert @doc.respond_to?(:image=)
        assert @doc.respond_to?(:image)
      end

      should "have embedded_image" do
        assert @doc.respond_to?(:embedded_image=)
        assert @doc.respond_to?(:embedded_image)   
      end

      should "assign a regular image" do
        @doc.image = Image.new
        @doc.save
        assert Doc.first.image
      end

      should "assign a regular document" do
        @doc.image = Image.create
        @doc.save
        assert Doc.first.image
      end

      should "wrap regular document assignments in embedded classes" do
        img = Image.new :name => 'Ryan'
        @doc.image = img
        assert_equal 'Ryan', @doc.embedded_image.name
      end

      should "embed a regular document" do
        @doc.image = Image.new :name => 'Ryan'
        assert @doc.save

        assert_equal 'Ryan', Doc.first.image.name
        assert_equal Image, Doc.first.image.class
      end

      context "with an embedded created image" do
        setup do
          @img = Image.create! :name => 'Ryan', :age => 27
          @doc.image = @img
          @doc.save!
        end

        should "embed a created object" do

          assert_equal 1, Image.count
          assert_equal @img.attributes, Doc.first.image.attributes
        end

        should "destroy an embedded doc" do
          d = Doc.first
          d.image = nil
          d.save!

          od = Doc.first
          assert_nil od.image
        end
      end
    end
  end
end
