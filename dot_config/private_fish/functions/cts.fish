function cts
  # compile type script
  npx ts-node --compilerOptions '{"strict":true}' $argv
end
