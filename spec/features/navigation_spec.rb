
require 'rails_helper'

describe 'As a visitor' do
  it 'I see a link to browse all items for sale' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('All Items')
      click_link 'All Items'
    end

    expect(current_path).to eq('/items')
  end

  it 'I see a link to see all merchants' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('All Merchants')
      click_link 'All Merchants'
    end

    expect(current_path).to eq('/merchants')
  end

  it 'I see a cart indicator link' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Cart: 0')
      click_link 'Cart: 0'
    end

    expect(current_path).to eq('/cart')
  end

  it 'I see a register link' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Register')
      click_link 'Register'
    end

    expect(current_path).to eq('/register')
  end

  it 'I see a link to home' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Home')
      click_link 'Home'
    end

    expect(current_path).to eq('/')
  end

  it 'I see a link to login' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Login')
      click_link 'Login'
    end

    expect(current_path).to eq('/login')
  end
end
