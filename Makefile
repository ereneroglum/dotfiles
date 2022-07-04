PACKAGES=$(shell find "${PWD}" -maxdepth 1 -mindepth 1 -type d -not -name ".git" -exec basename {} ';')

define generate_list
$(1)_install:
	stow -v -S -t "${HOME}" "$(1)"

$(1)_uninstall:
	stow -v -D -t "${HOME}" "$(1)"
endef
$(foreach i,$(PACKAGES),$(eval $(call generate_list,$(i))))

.PHONY: $(PACKAGES:=_install) $(PACKAGES:=_uninstall)

all: install

install: $(PACKAGES:=_install)

uninstall: $(PACKAGES:=_uninstall)

list:
	@ls -l | grep ^d | awk '{print $$9}'

clean:
	git reset --hard --recurse-submodules
	git clean -ffdx
	git submodule foreach --recursive git clean -ffdx
	git pull --recurse-submodules
