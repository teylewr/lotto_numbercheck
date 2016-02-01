Numbercheck::Application.routes.draw do
    root 'static_pages#home'
    get 'checker' => 'drawings#checker', as: :checker, :format => 'js'
end
