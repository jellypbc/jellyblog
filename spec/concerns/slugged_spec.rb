require 'rails_helper'

describe Slugged do
  let(:user) { create :user, :admin }

  describe 'validations' do
    let(:post) { create :post, user: user }

    # before { post.stub :set_placeholder_slug }

    context 'slug attribute presence' do
      context 'title is set' do
        before { post.title = 'This is a post' }

        it 'is valid' do
          expect(post).to be_valid
        end
      end

      context 'title is nil' do
        before { post.title = nil }

        it 'is not valid' do
          expect(post).to_not be_valid
        end
      end
    end

    context 'slug attribute uniqueness' do
      before { create :post, title: 'inspiring-new-methodology', user: user }

      context 'title is unique' do
        before { post.title = 'munged-title' }

        it 'is valid' do
          expect(post).to be_valid
        end
      end
    end

    context 'slug attribute blacklist' do
      context 'title is on the blacklist' do
        before { post.title = 'new' }

        it 'is not valid' do
          expect(post).to_not be_valid
        end
      end
    end
  end

  describe '#set_slug!' do
    context 'for a new post' do
      let(:post) { Post.new(user: user) }

      it 'sets title' do
        post.title = 'Shiny New Drug'
        date = Time.now.strftime("%Y-%m-%d")

        expect {
          post.set_slug!
        }.to change { post.slug }.from(nil).to("#{date}-shiny-new-drug")
      end
    end

    context 'for an existing post' do
      let(:post) { Post.new(user: user, slug:'wacky-old-theory')  }

      it 'updates title' do
        post.title = 'Staggering New Theory'
        date = Time.now.strftime("%Y-%m-%d")

        expect {
          post.set_slug!
        }.to change { post.slug }
          .from("wacky-old-theory").to("#{date}-staggering-new-theory")
      end
    end
  end
end
