require "rails_helper"

describe DelegationsController do
  describe "GET 'new'" do
    let(:action) { get :new }

    it 'responds ok' do
      action
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    let(:action) { post :create, params }

    let(:current_user)      { create :user }
    let(:delegated_voter)   { create :user }

    let(:params) do
      {
        delegation: {
          tag_list: ['ruby', 'rails'],
          delegation_entries_attributes: [
            {
              position: 1,
              delegate_id: delegated_voter.id,
              delegate_type: delegated_voter.class
            }
          ]
        }
      }
    end

    it 'creates 1 Delegation' do
      expect { action }.to change { Delegation.count }.to(1)
    end

    it 'creates 1 DelegationEntry' do
      expect { action }.to change { DelegationEntry.count }.to(1)
    end
  end
end
