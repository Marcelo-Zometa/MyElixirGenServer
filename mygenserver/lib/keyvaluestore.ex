defmodule KeyValueStore do
    #Initial state
    def init do
        %{}
    end

    #Handles the put request
    def handle_call({:put, key, value}, state) do
        {:ok, Map.put(state, key, value)}
    end

    #Handles the get request
    def handle_call({:get, key}, state) do
        {Map.get(state, key), state}
    end

    #Used to make the client oblivious of the server
    def start do
        ServerProcess.start(KeyValueStore)
    end

    def put(pid, key, value) do
        ServerProcess.call(pid, {:put, key, value})
    end

    def get(pid, key) do
        ServerProcess.call(pid, {:get, key})
    end
end