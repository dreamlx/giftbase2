class AddHashedSourceAndHashedTargetToMatchingSolutions < ActiveRecord::Migration
  def up
    add_column :matching_solutions, :hashed_source, :string
    add_index :matching_solutions, :hashed_source
    add_column :matching_solutions, :hashed_target, :string
    add_index :matching_solutions, :hashed_target

    MatchingSolution.all.each do |matching_solution|
      matching_solution.update_column(:hashed_source, Digest::MD5.hexdigest(matching_solution.source))
      matching_solution.update_column(:hashed_target, Digest::MD5.hexdigest(matching_solution.target))
    end
  end

  def down
    remove_column :matching_solutions, :hashed_target
    remove_column :matching_solutions, :hashed_source
  end
end
