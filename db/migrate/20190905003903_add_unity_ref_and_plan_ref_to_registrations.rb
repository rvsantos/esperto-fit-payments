class AddUnityRefAndPlanRefToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_reference :registrations, :unity, foreign_key: true
    add_reference :registrations, :plan, foreign_key: true
  end
end
