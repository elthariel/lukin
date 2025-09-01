# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Todo

- [x] Project setup
- [x] RubyLLM Setup
  - [x] basic runpod vllm support
  - [x] basic native ollama support
- [x] Basic models and chat UI
- [] Dorian
  - [x] Use GameRule/State/Character to describe a scenario with 'steps'
  - [x] Use a tool to allow the use to progress into steps
  - [] Find a way to reliably prompt the steps
  - [] List the steps in the game_rule and provide the possible values in param description
- [] Experiment with multiplayer aspects
  - [] Multiple people talking in the same context
  - [] Sharing a context summary between chats
- [] Implement some sort of agents on top of our existing "game" structure
  - [x] Basic agent poc
  - [/] Establish a more solid foundation for agents in the context of our "game"
- [] Image integration
  - [] Use runpod basic serverless comfy UI
  - [] Implement a default workflow / client
  - [] Use an agent/tool to generate prompt "when the mood change?"
- [] LoRA ...
