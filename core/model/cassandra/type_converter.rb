module Cassandra
  module Custom

    class TypeConverter < BasicObject

      # Cassandra Ruby Driver Implicity Supports Hash, Array, Integer, String, Float

      def self.convert(action, type, obj)
          self.send("#{action}#{type}", obj)
      end

      # Create Action

      def self.createIp(obj)
        begin
          ::Cassandra::Types::Inet.new(obj)
        rescue ::ArgumentError
          nil
        end
      end

      def self.createTime(obj)
        begin
          ::Cassandra::Types::Timestamp.new(obj)
        rescue ::ArgumentError
          nil
        end
      end

      def self.createTimeUuid(obj)
        ::Cassandra::Uuid::Generator.new.now
      end

      def self.createUuid(obj)
        ::Cassandra::Uuid::Generator.new.uuid
      end

      def self.createSexyDate(obj)
        ::Time.now.strftime("%y%m").to_i
      end

      def createArray(obj)
        begin
          obj.map do |e|
            e.to_s
          end
        rescue NoMethodError
          nil
        end
      end

      def createHash(obj)
        begin
          new_obj = {}
          obj.each do |k,v|
            new_obj[k] = v.to_s
          end
          new_obj
        rescue NoMethodError
          nil
        end
      end

      # Update Action
      def self.updateIp(obj)
        begin
          ::Cassandra::Types::Inet.new(obj)
        rescue ::ArgumentError
          nil
        end
      end

      def self.updateTime(obj)
        begin
          ::Cassandra::Types::Timestamp.new(obj)
        rescue ::ArgumentError
          nil
        end
      end

      def updateArray(obj)
        begin
          obj.map do |e|
            e.to_s
          end
        rescue NoMethodError
          nil
        end
      end

      def updateHash(obj)
        begin
          new_obj = {}
          obj.each do |k,v|
            new_obj[k] = v.to_s
          end
          new_obj
        rescue NoMethodError
          nil
        end
      end

      def self.method_missing(obj, *args, &block)
        args.first || 'Something wen wrong!'
      end


    end
  end
end
