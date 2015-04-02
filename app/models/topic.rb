class Topic < ActiveRecord::Base
	has_many :votes, dependent: :destroy

	def self.sorted
		find_by_sql(
			"SELECT topics.*,
			(SELECT count(votes.topic_id) FROM votes WHERE votes.topic_id = topics.id)
				AS votes_count
			FROM topics
			ORDER BY votes_count ASC"
		)
	end

	def votes_count
		attributes['votes_count'] || votes.count
	end
end
