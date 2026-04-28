# frozen_string_literal: true

# envelope_revisions.account_id — denormalized for ActsAsTenant scoping;
# backfilled from the parent envelope's account_id.
class AddAccountAndOrderSchema < ActiveRecord::Migration[8.1]
  def up
    add_reference :envelope_revisions, :account,
                  null: true, foreign_key: true, index: true
    execute <<~SQL.squish
      UPDATE envelope_revisions
      SET account_id = (
        SELECT envelopes.account_id
        FROM envelopes
        WHERE envelopes.id = envelope_revisions.envelope_id
      )
    SQL
    change_column_null :envelope_revisions, :account_id, false
  end

  def down
    remove_reference :envelope_revisions, :account, foreign_key: true
  end
end
