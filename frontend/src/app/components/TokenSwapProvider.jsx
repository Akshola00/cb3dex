import { createContext, useReducer } from "react"


const initial_token_Arg  = {
    buy:{
        token:"",
        amount:""
    },
    sell:{
        token:"",
        amount:0,
        price:0,
    }
}
export const TokenContext = createContext({...initial_token_Arg});

const reducer = function(state,action){
    if(action.type==="buy/token"){
        return {...state,buy:{...state.buy,token:state.payload}}
    }
    if(action.type==="buy/amount"){
        return {...state,buy:{...state.buy,amount:state.payload}}
    }
    if(action.type==="sell/token"){
        return {...state,sell:{...state.sell,token:state.payload}}
    }
    if(action.type==="sell/token"){
        return {...state,sell:{...state.sell,amount:state.payload}}
    }

    return initial_token_Arg
}

function TokenContextProvider ({children}){
    const [state, dispatcher] = useReducer(reducer,initial_token_Arg)
    return <TokenContext.Provider value={{...state, dispatcher}}>{children}</TokenContext.Provider>
}

export default TokenContextProvider