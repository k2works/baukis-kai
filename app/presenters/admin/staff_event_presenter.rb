class Admin::StaffEventPresenter < ModelPresenter
  delegate :member, :description, :occurred_at, to: :object

  def table_row
    markup(:tr, class:'Table__tr') do |m|
      unless view_context.instance_variable_get(:@staff_member)
        m.td(class: 'Table__td') do
          m << link_to(member.family_name + member.given_name,[:admin, member, :staff_events])
        end
        m.td description , class: 'Table__td'
        m.td(class: 'Table__td Table__td--date') do
          m.text occurred_at.strftime('%Y/%m/%d %H:%M:%S')
        end
      end
    end
  end

end