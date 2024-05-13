- Stock Exchange

  - Companies

    - id, name, ceo, description, hq, founded, url_favicon, url_webpage, market_cap, country, sector

  - Assets

    - id, name, sym, company_id, price, url_icon, type(stocks,bonds,mutual funds), market_cap, volume, price_open, dayHi, dayLo, price_close, yearHi, yearLo, status, pe_ratio,dividend_yield, average_volume

  - AssetPrices

    - id, asset_id, timestamp, source, volume, price_open, price_hi, price_lo, price_close

  - Orders

    - id, user_id, asset_id, asset_type, price_asset, amount, quantity, status(open, partial_fill, filled, cancelled, rejected, expired, closed), strike, price_limit, price_stop, expires, order_type(buy, limit, stop_loss, stop_limit, trailing_stop), buy_in(shares, dollars), trail_type(percentage, amount), trail_percentage, trail_amount

  - OrderBooks

    - id, sym, current_bid_price, current_ask_price, current_bid_quantity, current_ask_quantity, last_update, bids, asks

  - Users

    - id, email, pw_digest, first_name, last_name, phone(18506928301),

  - Accounts

    - id, user_id, number, routing, institution, value, type(seep_deep, bank), name, nickname

  - Transfers
    - id, user_id, account_id, value, type(credit[inbound],debit[outbound]), status(open, cancelled, completed, rejected, closed)
