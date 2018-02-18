city_names = %w(青巻市 赤巻市　貴巻市)

family_name = %w{
  三木:ミキ:miki
  坂口:サカグチ:sakacuchi
  瀬戸:セト:seto
  永田:ナガタ:nagata
  黒田:クロダ:kuroda
  西:ニシ:nishi
  三好:ミヨシ:miyoshi
  菊地:キクチ:kikuchi
  内山:ウチヤマ:uchiyama
  米田:ヨネダ:yoneda
}

given_name = %w{
  徳彦:ノリヒコ:norihiko
  正宏:マサノリ:masanori
  弘義:ヒロヨシ:hiroyoshi
  美則:ヨシノリ:yoshinori
  智治:トモノリ:tomonori
  雄樹:ユウキ:yuki
  博男:ヒロオ:hiroo
  勇四郎:ユウシロウ:yushiro
  一人:カズト:kazuto
  令:レイ:rei
}

company_names = %w(OIAX ABC XYZ)

10.times do |n|
    fn = family_name[n].split(':')
    gn = given_name[n].split(':')

    c = Customer.create!(
      email: "#{fn[2]}@example.jp",
      family_name: fn[0],
      given_name: gn[0],
      family_name_kana: fn[1],
      given_name_kana: gn[1],
      password: 'password',
      birthday: 60.years.ago.advance(seconds: rand(40.years.to_i)).to_date,
      gender: n < 5 ? 'male' : 'female'
    )
    if n % 2 == 0
      c.personal_phones.create!(number: sprintf('090-0000-%04d', n))
    end
    c.create_home_address!(
      postal_code: sprintf('%07d', rand(10000000)),
      prefecture: Address::PREFECTURE_NAMES.sample,
      city: city_names.sample,
      address1: '開発1-2-3',
      address2: 'レイルズハイツ301号室'
    )
    if n % 5 == 0
      c.home_address.phones.create!(number: sprintf('03-0000-%04d', n))
    end

    if n % 3 == 0
      c.create_work_address!(
        postal_code: sprintf('%07d', rand(10000000)),
        prefecture: Address::PREFECTURE_NAMES.sample,
        city: city_names.sample,
        address1: '試験4-5-6',
        address2: 'ルビービル2F',
        company_name: company_names.sample
      )
    end
end
