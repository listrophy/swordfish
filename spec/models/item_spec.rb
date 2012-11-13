require 'spec_helper'

describe Item do
  let(:item) { Item.new }

  describe 'share_with' do
    context 'with a user' do
      let(:user) { User.new }

      it 'creates a share' do
        share = item.share_with(user, 'mykey')
        expect(share).to be_instance_of(Share)
        expect(share).not_to be_new_record
        expect(share.key).to eql('mykey')
        expect(share.user_id).to eql(user.id)
      end
    end

    context 'with a team' do
      let(:team) { Team.new }

      it 'creates a share' do
        share = item.share_with(team, 'mykey')
        expect(share).to be_instance_of(Share)
        expect(share).not_to be_new_record
        expect(share.key).to eql('mykey')
        expect(share.team_id).to eql(team.id)
      end
    end
  end

  describe 'share_for' do
    let(:user) { User.new }

    it 'finds user share' do
      share = item.share_with(user, 'userkey')
      expect(item.share_for(user)).to eql(share)
    end

    it 'finds share through team' do
      team = Team.new
      team.add user, 'userkey'
      share = item.share_with(team, 'teamkey')
      expect(item.share_for(user)).to eql(share)
    end
  end
end