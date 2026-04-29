# frozen_string_literal: true

class CreateReportShares < ActiveRecord::Migration[8.1]
  def up
    add_column :accounts, :report_share_max_days, :integer, default: 365, null: false unless column_exists?(:accounts, :report_share_max_days)

    create_table :report_shares do |t|
      t.string :prefix_id
      t.references :account, null: false, foreign_key: true
      t.references :report, null: false, foreign_key: true
      t.references :envelope, null: false, foreign_key: true
      t.references :envelope_revision, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :token_digest, null: false
      t.text :token_ciphertext
      t.string :title
      t.datetime :expired_at, null: false
      t.datetime :last_viewed_at
      t.integer :view_count, default: 0, null: false
      t.string :html_sha256
      t.bigint :byte_size

      t.timestamps
    end

    add_index :report_shares, :prefix_id, unique: true
    add_index :report_shares, :token_digest, unique: true
    add_index :report_shares, [:account_id, :report_id]
    add_index :report_shares, :expired_at
  end

  def down
    drop_table :report_shares, if_exists: true
    remove_column :accounts, :report_share_max_days if column_exists?(:accounts, :report_share_max_days)
  end
end
