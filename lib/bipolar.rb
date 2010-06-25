module Bipolar

  def self.configure(model)
    model.class_inheritable_accessor :bipolar_associations
    model.bipolar_associations = Set.new
  end

  module ClassMethods
    def embeds_one name, options = {}
      one "embedded_#{name}", options.reverse_merge(:class => embedded_klass(name), :in => name)
    
      class_eval <<-EOF
        def #{name}
          self.class.associated_klass("#{name}").new embedded_#{name}.attributes
        end
        
        def #{name}= val
          if val.nil?
            self.embedded_#{name} = nil
          else
            self.embedded_#{name} = self.class.embedded_klass(val.class).new(val.attributes)
          end 
        end 
      EOF
    end

    def embeds_many name, options = {}
      many "embedded_#{name}", options.reverse_merge(:class => embedded_klass(name), :in => name)
    
      class_eval <<-EOF
        def #{name}
          embedded_#{name}.map do |e|
            self.class.associated_klass("#{name}").new e.attributes
          end
        end
        
        def #{name}= val
          if val.nil?
            self.embedded_#{name} = nil
          else
            self.embedded_#{name} = val.map do |v|          
              self.class.embedded_klass(v.class).new(v.attributes)
            end
          end
        end
      EOF
    end


    def associated_klass(name)
      name.to_s.singularize.camelize.constantize
    end

    def embedded_klass(name)
      if !associated_klass(name).const_defined?(:Embedded)
        associated_klass(name).class_eval <<-EOF
          class Embedded < self
            include MongoMapper::EmbeddedDocument
          end
        EOF
      end
      
      associated_klass(name).const_get :Embedded
    end
  end

end
