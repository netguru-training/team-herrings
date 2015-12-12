module Admin
  class TablesController < AdminController
    expose(:tables) { Table.all }
    expose(:table, attributes: :table_params)

    def create
      if table.save
        redirect_to admin_table_path(table), notice: I18n.t('shared.created', resource: 'Table')
      else
        render :new
      end
    end

    def update
      if table.save
        redirect_to admin_table_path(table), notice: I18n.t('shared.updated', resource: 'Table')
      else
        render :edit
      end
    end

    def destroy
      table.destroy
      redirect_to admin_tables_path, notice: I18n.t('shared.deleted', resource: 'Table')
    end

    private

    def table_params
      params.require(:table).permit(:name, :places, :location)
    end
  end
end
