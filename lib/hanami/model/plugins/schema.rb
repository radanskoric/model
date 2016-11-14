module Hanami
  module Model
    module Plugins
      # Transform input values into database specific types (primitives).
      #
      # @since 0.7.0
      # @api private
      module Schema
        # Takes the input and applies the values transformations.
        #
        # @since 0.7.0
        # @api private
        class InputWithSchema < WrappingInput
          # @since 0.7.0
          # @api private
          def initialize(relation, input)
            super
            @schema = relation.schema_hash
          end

          # Processes the input
          #
          # @since 0.7.0
          # @api private
          def [](value)
            @schema[@input[value]]
          end
        end

        # Class interface
        #
        # @since 0.7.0
        # @api private
        module ClassMethods
          # Builds the input processor
          #
          # @since 0.7.0
          # @api private
          def build(relation, options = {})
            input(InputWithSchema.new(relation, input))
            super(relation, options.merge(input: input))
          end
        end

        # @since 0.7.0
        # @api private
        def self.included(klass)
          super

          klass.extend ClassMethods
        end
      end
    end
  end
end
