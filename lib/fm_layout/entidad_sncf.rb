module FmLayout
  class EntidadSNCF

    include ::FmLayout::FmSeccionNomina

    def initialize
      @titulo = "EntidadSNCF"
      @datos  = {}
    end

    def self.campos_vs_metodos
      {
        'OrigenRecurso'      => 'origen_recurso',
        'MontoRecursoPropio' => 'monto_recurso_propio',
      }
    end

    # Creación de los métodos de acceso dinámicamente
    campos_vs_metodos.each do |campo, metodo|
      define_method(metodo) do |dato|
        @datos[campo] = dato
      end
    end

  end
end
