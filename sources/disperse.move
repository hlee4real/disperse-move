module 0x1::disperse{
    use aptos_framework::coin;
    use std::vector;

    public entry fun disperse<CoinType>(sender: &signer, to: vector<address>, amounts: vector<u64>) {
        let i : u64 = 0;
        let len = vector::length(&to);
        while (i < len){
            let amount = vector::borrow(&mut amounts, i);
            let coins = coin::withdraw<CoinType>(sender, *amount);
            let to_addr = vector::borrow(&mut to, i);
            coin::deposit<CoinType>(*to_addr, coins);
            i = i + 1;
        }
    }

    public entry fun disperse_with_check<CoinType>(sender: &signer, to: vector<address>, amounts: vector<u64>) {
        let i : u64 = 0;
        let len = vector::length(&to);
        while (i < len){
            let amount = vector::borrow(&mut amounts, i);
            let to_addr = vector::borrow(&mut to, i);
            if (coin::is_account_registered<CoinType>(*to_addr)){
                let coins = coin::withdraw<CoinType>(sender, *amount);
                coin::deposit<CoinType>(*to_addr, coins);
            };
            i = i + 1;
        }
    }

}