shared_examples 'a protected admin controller' do
  describe '#index' do
    # ログインフォームにリダイレクト
    it 'should redirect to login form' do
      get :index
      expect(response).to redirect_to(admin_login_url)
    end
  end

  describe '#show' do
    # ログインフォームにリダイレクト
    it 'should redirect to login form' do
      get :show, params: { id: 1 }
      expect(response).to redirect_to(admin_login_url)
    end
  end
end

shared_examples 'a protected singular admin controller' do
  describe '#show' do
    # ログインフォームにリダイレクト
    it 'should redirect to login form' do
      get :show
      expect(response).to redirect_to(admin_login_url)
    end
  end
end
