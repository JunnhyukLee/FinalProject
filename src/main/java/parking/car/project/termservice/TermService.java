package parking.car.project.termservice;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.inject.Inject;
import parking.car.project.termdto.TermDTO;
import parking.car.project.termentity.Term;
import parking.car.project.termrepository.TermRepository;

@Service
public class TermService {

    @Inject
    private TermRepository termRepository;

    @Transactional(readOnly = true)
    public List<TermDTO> termSelectAll() {
        List<Term> terms = termRepository.findAll();
        return terms.stream()
                    .map(term -> {
                        TermDTO dto = new TermDTO();
                        dto.setTerm_code(term.getTerm_code());
                        dto.setTerm_content(term.getTerm_content());
                        return dto;
                    })
                    .collect(Collectors.toList());
    }
}