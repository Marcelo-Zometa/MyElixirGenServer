defmodule KeyValueStore do
    use GenServer

    #Initial state
    #{:stop, reason} return this if something goes wrong
    def init(_) do
        {:ok, %{}}

        #Sends a message to the server every 5000
        :timer.send_interval(5000, :cleanup)
    end

    #Handles the put request
    def handle_cast({:put, key, value}, state) do
        {:noreply, Map.put(state, key, value)}
    end

    #Handles the get request
    #Second argument is tuple with id of caller
    def handle_call({:get, key}, _, state) do
        {:reply, Map.get(state, key), state}
    end

    #Handles messages sent by timer
    def handle_info(:cleanup, state) do
        IO.puts("performing cleanup")
        {:noreply, state}
    end

    #Used to make the client oblivious of the server
    def start do
        GenServer.start(KeyValueStore, nil, name: __MODULE__)
    end

    def put(key, value) do
        GenServer.cast(__MODULE__, {:put, key, value})
    end

    #Third argument is timeout in miliseconds
    def get(pid, key) do
        GenServer.call(pid, {:get, key})
    end
end
