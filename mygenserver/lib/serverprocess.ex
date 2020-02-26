defmodule ServerProcess do
  @moduledoc """
  Documentation for Mygenserver.
  """

  @doc """
    This code was taken from the following link
    https://learning.oreilly.com/library/view/elixir-in-action/9781617295027/c06.xhtml
  """
  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init()
      loop(callback_module, initial_state)
    end)
  end

  #Issues a cast message
  def cast(server_pid, request) do
    send(server_pid, {:cast, request})
  end

  defp loop(callback_module, current_state) do
    receive do
      {:call, request, caller} ->
        {response, new_state} =
          #Invokes the callback to handle the message
          callback_module.handle_call(request, current_state)

          #Sends the response back
          send(caller, {:response, response})

          #Loops back with a new state
          loop(callback_module, new_state)

      {:cast, request} ->
        new_state =
          callback_module.handle_cast(request, current_state)

          loop(callback_module, new_state)
    end
  end

  def call(server_pid, request) do
    #Talk to server
    send(server_pid, {:call, request, self()})

    receive do
      {:response, response} ->
        #Just return response got
        response
    end
  end

  def hello do
    :world
  end
end
