# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/group.html.erb', type: :view do
  before(:each) do
    assign(:post, Post.new(
                    description: 'MyText',
                    user_id: 1
                  ))
  end

  it 'renders group.html.erb post form' do
    render

    assert_select 'form[action=?][method=?]', posts_path, 'post' do
      assert_select 'textarea[name=?]', 'post[decription]'

      assert_select 'input[name=?]', 'post[user_id]'
    end
  end
end
