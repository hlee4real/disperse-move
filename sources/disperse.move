module 0x1::disperse{
    use aptos_framework::coin;
    use std::vector;

    public entry fun disperse<CoinType>(sender: &signer, recipients: vector<address>, amounts: vector<u64>) {
        let i : u64 = 0;
        let len = vector::length(&recipients);
        while (i < len){
            let amount = vector::borrow(&mut amounts, i);
            let coins = coin::withdraw<CoinType>(sender, *amount);
            let recipient = vector::borrow(&mut recipients, i);
            coin::deposit<CoinType>(*recipient, coins);
            i = i + 1;
        }
    }

    public entry fun disperse_with_check<CoinType>(sender: &signer, recipients: vector<address>, amounts: vector<u64>) {
        let i : u64 = 0;
        let len = vector::length(&recipients);
        while (i < len){
            let amount = vector::borrow(&mut amounts, i);
            let recipient = vector::borrow(&mut recipients, i);
            if (coin::is_account_registered<CoinType>(*recipient)){
                let coins = coin::withdraw<CoinType>(sender, *amount);
                coin::deposit<CoinType>(*recipient, coins);
            };
            i = i + 1;
        }
    }

}