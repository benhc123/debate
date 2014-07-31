require 'rails_helper'

RSpec.describe Issue, versioning: true do
  it "saves a version when a thesis is added" do
    issue = create(:issue)
    num_versions = issue.versions.count

    thesis_params = attributes_for(:thesis)
    service = CreateThesisRelatedToIssue.new(thesis_params, issue, Thesis::POSITIONS::AGAINST)
    service.run

    expect(issue.versions.count).to eq(num_versions + 1)
  end

  it "saves a version when a thesis is removed" do
    issue = create(:issue)
    thesis_params = attributes_for(:thesis)
    service = CreateThesisRelatedToIssue.new(thesis_params, issue, Thesis::POSITIONS::AGAINST)
    service.run

    num_versions = issue.versions.count
    issue.remove_thesis(service.thesis)

    expect(issue.versions.count).to eq(num_versions + 1)
  end

  it "saves a version when one of its theses makes a new version" do
    issue = create(:issue)
    thesis_params = attributes_for(:thesis)
    service = CreateThesisRelatedToIssue.new(thesis_params, issue, Thesis::POSITIONS::AGAINST)
    service.run

    num_versions = issue.versions.count
    UpdateThesis.new(service.thesis, {summary: 'Revised'}, issue).run

    expect(issue.versions.count).to eq(num_versions + 1)
  end

  describe "#revert_to!(version_number)" do
    it "reverts the issue's theses to the versions they were at when the issue's version that we're reverting to was made" do
      issue = create(:issue)

      thesis_params = attributes_for(:thesis).merge(summary: 'Thesis1')
      service = CreateThesisRelatedToIssue.new(thesis_params, issue, Thesis::POSITIONS::AGAINST)
      service.run
      thesis1 = service.thesis

      thesis_params = attributes_for(:thesis).merge(summary: 'Thesis2')
      service = CreateThesisRelatedToIssue.new(thesis_params, issue, Thesis::POSITIONS::AGAINST)
      service.run
      thesis2 = service.thesis

      initial_version_number = issue.versions.last.index

      UpdateThesis.new(thesis1, {summary: "Revised#{thesis1.id}"}, issue).run
      UpdateThesis.new(thesis2, {summary: "Revised#{thesis2.id}"}, issue).run

      issue.revert_to!(initial_version_number)

      expect(thesis1.reload.summary).to eq('Thesis1')
      expect(thesis2.reload.summary).to eq('Thesis2')
    end
  end
end
