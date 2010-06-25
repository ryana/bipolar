module Bipolar
  Version = '0.1.0'

  module Embedded; end

  def self.configure(model)
    model.class_inheritable_accessor :bipolar_associations
    model.bipolar_associations = Set.new
  end

  module ClassMethods
    def embeds_one name, options = {}
      one "embedded_#{name}", options.reverse_merge(:class => embedded_klass(name), :in => name)
    
      class_eval <<-EOF
        def #{name}
          if embedded_#{name}.attributes.nil?
            nil
          else
            # self.class.associated_klass("#{name}").new embedded_#{name}.attributes
             embedded_#{name}
          end
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
          (embedded_#{name} || []).map do |e|
            #self.class.associated_klass("#{name}").new e.attributes
             e
          end
        end
        
        def #{name}= val
          if val.nil?
            self.embedded_#{name} = []
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
      if !Bipolar::Embedded.const_defined? associated_klass(name).to_s
        associated_klass(name).class_eval <<-EOF
          class Bipolar::Embedded::#{associated_klass(name)} < self
            include MongoMapper::EmbeddedDocument
          end
        EOF
      end
      
      Bipolar::Embedded.const_get associated_klass(name).to_s
    end
  end

end
