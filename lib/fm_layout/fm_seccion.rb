module FmLayout
  module FmSeccion
    def titulo
      @titulo
    end

    def to_h
      { @titulo => @datos }
    end

    def to_s
      separador = @separador || '|'

      salida = "[#{@titulo}]\r\n\r\n"
      @datos.each do |k,v|
        salida += "#{k}#{separador}#{v}\r\n"
      end
      salida += "\r\n"
      salida
    end
  end

  module FmSeccionNomina
    include FmSeccion

    def to_s
      salida = "[#{@titulo}]\r\n\r\n"
      @datos.each do |k,v|
        salida += "#{k}=#{v}\r\n"
      end
      salida += "\r\n"
      salida
    end
  end

end
